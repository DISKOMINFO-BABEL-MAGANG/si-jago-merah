<?php

namespace App\Filament\Resources\LaporanWargas;

use App\Filament\Resources\LaporanWargas\Pages\ManageLaporanWargas;
use App\Models\LaporanWarga;
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

class LaporanWargaResource extends Resource
{
    protected static ?string $model = LaporanWarga::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Laporan Warga';
    protected static string|UnitEnum|null $navigationGroup = 'Operasional';
    protected static ?int $navigationSort = 2;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            TextInput::make('nama_pelapor'), TextInput::make('no_kontak_pelapor')->tel(),
            Select::make('jenis_laporan')->options(['kebakaran' => 'Kebakaran', 'evakuasi_penyelamatan' => 'Evakuasi & penyelamatan'])->required(),
            Select::make('status')->options(['baru' => 'Baru', 'diverifikasi' => 'Diverifikasi', 'ditindaklanjuti' => 'Ditindaklanjuti', 'ditolak' => 'Ditolak'])->required()->default('baru'),
            TextInput::make('alamat_lokasi')->columnSpanFull(), TextInput::make('latitude')->numeric(), TextInput::make('longitude')->numeric(),
            Textarea::make('deskripsi_singkat')->columnSpanFull(), TextInput::make('foto_url')->url()->label('URL foto')->columnSpanFull(),
            DateTimePicker::make('waktu_lapor')->required()->default(now()),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->defaultSort('waktu_lapor', 'desc')->columns([
            TextColumn::make('waktu_lapor')->label('Waktu lapor')->dateTime('d M Y, H:i')->sortable(),
            TextColumn::make('nama_pelapor')->label('Pelapor')->searchable()->placeholder('-'),
            TextColumn::make('jenis_laporan')->label('Jenis')->formatStateUsing(fn (string $state) => str($state)->replace('_', ' ')->title()),
            TextColumn::make('alamat_lokasi')->label('Lokasi')->limit(35)->searchable(),
            TextColumn::make('status')->badge()->color(fn (string $state) => match ($state) {'baru' => 'warning', 'diverifikasi' => 'info', 'ditindaklanjuti' => 'success', default => 'danger'}),
        ])->filters([SelectFilter::make('status')->options(['baru' => 'Baru', 'diverifikasi' => 'Diverifikasi', 'ditindaklanjuti' => 'Ditindaklanjuti', 'ditolak' => 'Ditolak'])])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManageLaporanWargas::route('/')]; }
}
