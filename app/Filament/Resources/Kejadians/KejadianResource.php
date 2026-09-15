<?php

namespace App\Filament\Resources\Kejadians;

use App\Filament\Resources\Kejadians\Pages\ManageKejadians;
use App\Models\Kejadian;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TimePicker;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use UnitEnum;

class KejadianResource extends Resource
{
    protected static ?string $model = Kejadian::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $navigationLabel = 'Kejadian';

    protected static string|UnitEnum|null $navigationGroup = 'Operasional';

    protected static ?int $navigationSort = 1;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            Select::make('jenis_kejadian')->options([
                'kebakaran' => 'Kebakaran',
                'evakuasi_penyelamatan' => 'Evakuasi & penyelamatan',
            ])->required(),
            DatePicker::make('tanggal_kejadian')->required(),
            TimePicker::make('waktu_kejadian'),
            Select::make('pos_id')->relationship('pos', 'nama_pos')->searchable()->preload()->label('Pos damkar'),
            Select::make('laporan_warga_id')->relationship('laporanWarga', 'nama_pelapor')->searchable()->preload()->label('Laporan warga sumber'),
            TextInput::make('alamat_lokasi')->columnSpanFull(),
            TextInput::make('latitude')->numeric(),
            TextInput::make('longitude')->numeric(),
            TextInput::make('pelapor_asal'),
            TextInput::make('no_kontak_pelapor')->tel(),
            DateTimePicker::make('waktu_laporan_diterima'),
            DateTimePicker::make('waktu_tiba_lokasi'),
            Textarea::make('kronologi')->columnSpanFull(),
            TextInput::make('pemilik'),
            Textarea::make('dampak_kerugian'),
            TextInput::make('korban_luka')->numeric()->default(0)->minValue(0),
            TextInput::make('korban_meninggal')->numeric()->default(0)->minValue(0),
            Textarea::make('kendala_lapangan')->columnSpanFull(),
            DateTimePicker::make('waktu_selesai'),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->defaultSort('tanggal_kejadian', 'desc')->columns([
            TextColumn::make('jenis_kejadian')->label('Jenis')->formatStateUsing(fn (string $state) => str($state)->replace('_', ' ')->title()),
            TextColumn::make('tanggal_kejadian')->label('Tanggal')->date('d M Y')->sortable(),
            TextColumn::make('alamat_lokasi')->label('Lokasi')->limit(40)->searchable(),
            TextColumn::make('pos.nama_pos')->label('Pos')->placeholder('-'),
            TextColumn::make('korban_luka')->label('Luka')->numeric(),
            TextColumn::make('korban_meninggal')->label('Meninggal')->numeric(),
        ])->filters([
            SelectFilter::make('jenis_kejadian')->options(['kebakaran' => 'Kebakaran', 'evakuasi_penyelamatan' => 'Evakuasi & penyelamatan']),
        ])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array
    {
        return ['index' => ManageKejadians::route('/')];
    }
}
