<?php

namespace App\Console\Commands;

use App\Models\HimawariFetchLog;
use Carbon\Carbon;
use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Symfony\Component\Process\Process;

#[Signature('himawari:fetch')]
#[Description('Mengambil, mendeteksi, dan mengimpor data hotspot Himawari-9')]
class FetchHimawari extends Command
{
    public function handle(): int
    {
        $this->info('========================================');
        $this->info('   FETCH HIMAWARI-9');
        $this->info('========================================');

        $fetchLog = HimawariFetchLog::create([
            'status' => 'running',
            'step_reached' => 'download',
            'started_at' => now(),
        ]);

        try {
            // =====================================================
            // 1. FETCH DATA HIMAWARI
            // =====================================================

            $this->newLine();
            $this->info('1. Mengambil data Himawari-9...');

            $fetch = new Process([
                'python',
                base_path('himawari/fetch_himawari.py'),
            ]);

            $fetch->setTimeout(600);
            $fetch->run();

            if (! $fetch->isSuccessful()) {
                $err = trim($fetch->getErrorOutput() ?: $fetch->getOutput());
                $this->error('Gagal mengambil data Himawari-9.');

                if ($err) {
                    $this->error($err);
                }

                $fetchLog->update([
                    'status' => 'failed',
                    'step_reached' => 'download',
                    'message' => 'Gagal mengambil data Himawari-9 dari NOAA AWS S3.',
                    'source_errors' => ['download' => substr($err, 0, 1000)],
                    'finished_at' => now(),
                ]);

                return self::FAILURE;
            }

            if ($fetch->getOutput()) {
                $this->line(
                    trim($fetch->getOutput())
                );
            }

            // =====================================================
            // 2. DETEKSI HOTSPOT
            // =====================================================

            $this->newLine();
            $this->info('2. Mendeteksi hotspot Himawari-9...');

            $fetchLog->update([
                'step_reached' => 'detection',
            ]);

            $detect = new Process([
                'python',
                base_path('himawari/detect_hotspot.py'),
            ]);

            $detect->setTimeout(600);
            $detect->run();

            if (! $detect->isSuccessful()) {
                $err = trim($detect->getErrorOutput() ?: $detect->getOutput());
                $this->error(
                    'Gagal menjalankan deteksi hotspot Himawari-9.'
                );

                if ($err) {
                    $this->error($err);
                }

                $fetchLog->update([
                    'status' => 'failed',
                    'step_reached' => 'detection',
                    'message' => 'Gagal menjalankan algoritma deteksi hotspot Himawari-9.',
                    'source_errors' => ['detection' => substr($err, 0, 1000)],
                    'finished_at' => now(),
                ]);

                return self::FAILURE;
            }

            if ($detect->getOutput()) {
                $this->line(
                    trim($detect->getOutput())
                );
            }

            // =====================================================
            // 3. IMPORT KE DATABASE
            // =====================================================

            $this->newLine();
            $this->info('3. Mengimpor hotspot ke database...');

            $fetchLog->update([
                'step_reached' => 'import',
            ]);

            $import = new Process([
                PHP_BINARY,
                base_path('artisan'),
                'himawari:import',
            ]);

            $import->setTimeout(600);
            $import->run();

            if (! $import->isSuccessful()) {
                $err = trim($import->getErrorOutput() ?: $import->getOutput());
                $this->error(
                    'Gagal mengimpor data Himawari-9 ke database.'
                );

                if ($err) {
                    $this->error($err);
                }

                $fetchLog->update([
                    'status' => 'failed',
                    'step_reached' => 'import',
                    'message' => 'Gagal mengimpor data hasil deteksi ke database.',
                    'source_errors' => ['import' => substr($err, 0, 1000)],
                    'finished_at' => now(),
                ]);

                return self::FAILURE;
            }

            $importOutput = $import->getOutput() ?: '';
            if ($importOutput) {
                $this->line(
                    trim($importOutput)
                );
            }

            // =====================================================
            // HITUNG STATISTIK & OBSERVATION TIME
            // =====================================================

            $saved = 0;
            $updated = 0;
            $totalFetched = 0;

            if (preg_match('/Data baru\s*:\s*(\d+)/i', $importOutput, $m)) {
                $saved = (int) $m[1];
            }
            if (preg_match('/Data diperbarui\s*:\s*(\d+)/i', $importOutput, $m)) {
                $updated = (int) $m[1];
            }
            if (preg_match('/Total JSON\s*:\s*(\d+)/i', $importOutput, $m)) {
                $totalFetched = (int) $m[1];
            }

            $observationUtc = null;
            $manifestPath = base_path('himawari/data/latest.json');
            if (File::exists($manifestPath)) {
                try {
                    $manifestData = json_decode(File::get($manifestPath), true);
                    if (!empty($manifestData['observation_utc'])) {
                        $observationUtc = Carbon::parse($manifestData['observation_utc']);
                    }
                } catch (\Throwable) {
                    // ignore
                }
            }

            $message = $totalFetched > 0
                ? "Fetch dan deteksi Himawari-9 selesai: {$totalFetched} titik terdeteksi ({$saved} baru, {$updated} diperbarui)."
                : 'Fetch dan deteksi Himawari-9 selesai: tidak ada hotspot terdeteksi.';

            $fetchLog->update([
                'status' => 'success',
                'step_reached' => 'completed',
                'observation_time' => $observationUtc,
                'total_fetched' => $totalFetched,
                'total_saved' => $saved,
                'total_updated' => $updated,
                'message' => $message,
                'finished_at' => now(),
            ]);

            // =====================================================
            // SELESAI
            // =====================================================

            $this->newLine();
            $this->info('========================================');
            $this->info('   FETCH HIMAWARI SELESAI');
            $this->info('========================================');

            return self::SUCCESS;
        } catch (\Throwable $e) {
            $this->error('Terjadi pengecualian: ' . $e->getMessage());

            $fetchLog->update([
                'status' => 'failed',
                'message' => 'Terjadi kesalahan sistem: ' . $e->getMessage(),
                'source_errors' => ['exception' => substr($e->getMessage() . "\n" . $e->getTraceAsString(), 0, 1000)],
                'finished_at' => now(),
            ]);

            return self::FAILURE;
        }
    }
}