<?php

namespace App\Filament\Resources\PendaftaranEdukasis;

use App\Filament\Resources\PendaftaranEdukasis\Pages\ManagePendaftaranEdukasis;
use App\Models\PendaftaranEdukasi;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use UnitEnum;

class PendaftaranEdukasiResource extends Resource
{
    protected static ?string $model = PendaftaranEdukasi::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Pendaftaran Edukasi';
    protected static string|UnitEnum|null $navigationGroup = 'Edukasi';
    protected static ?int $navigationSort = 2;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            Select::make('kegiatan_id')->relationship('kegiatan', 'tema')->searchable()->preload()->required()->label('Kegiatan'),
            Select::make('status')->options(['menunggu' => 'Menunggu', 'terkonfirmasi' => 'Terkonfirmasi', 'hadir' => 'Hadir', 'dibatalkan' => 'Dibatalkan'])->required()->default('menunggu'),
            TextInput::make('nama_pendaftar')->required(), TextInput::make('no_hp')->tel()->required(), TextInput::make('email')->email(), TextInput::make('instansi_asal'),
            TextInput::make('jumlah_peserta')->numeric()->minValue(1)->default(1), DateTimePicker::make('tanggal_daftar')->required()->default(now()),
            Textarea::make('catatan')->columnSpanFull(),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->defaultSort('tanggal_daftar', 'desc')->columns([
            TextColumn::make('tanggal_daftar')->label('Terdaftar')->dateTime('d M Y, H:i')->sortable(), TextColumn::make('nama_pendaftar')->label('Pendaftar')->searchable(),
            TextColumn::make('kegiatan.tema')->label('Kegiatan')->limit(35), TextColumn::make('jumlah_peserta')->label('Peserta')->numeric(),
            TextColumn::make('status')->badge()->color(fn (string $state) => match ($state) {'menunggu' => 'warning', 'terkonfirmasi' => 'info', 'hadir' => 'success', default => 'gray'}),
        ])->filters([SelectFilter::make('status')->options(['menunggu' => 'Menunggu', 'terkonfirmasi' => 'Terkonfirmasi', 'hadir' => 'Hadir', 'dibatalkan' => 'Dibatalkan'])])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManagePendaftaranEdukasis::route('/')]; }
}
