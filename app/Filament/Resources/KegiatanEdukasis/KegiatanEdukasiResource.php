<?php

namespace App\Filament\Resources\KegiatanEdukasis;

use App\Filament\Resources\KegiatanEdukasis\Pages\ManageKegiatanEdukasis;
use App\Models\KegiatanEdukasi;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\DatePicker;
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

class KegiatanEdukasiResource extends Resource
{
    protected static ?string $model = KegiatanEdukasi::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Kegiatan Edukasi';
    protected static string|UnitEnum|null $navigationGroup = 'Edukasi';
    protected static ?int $navigationSort = 1;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            DatePicker::make('tanggal')->required(), TimePicker::make('waktu'),
            TextInput::make('tema')->columnSpanFull(), TextInput::make('tempat'), TextInput::make('jenis_tempat')->label('Jenis tempat'),
            TextInput::make('alamat')->columnSpanFull(), TextInput::make('kapasitas')->numeric()->default(0)->minValue(0),
            Select::make('pos_id')->relationship('pos', 'nama_pos')->searchable()->preload()->label('Pos damkar'),
            Select::make('status')->options(['terjadwal' => 'Terjadwal', 'berlangsung' => 'Berlangsung', 'selesai' => 'Selesai', 'dibatalkan' => 'Dibatalkan'])->required()->default('terjadwal'),
            Textarea::make('hasil_kegiatan')->columnSpanFull(),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->defaultSort('tanggal', 'desc')->columns([
            TextColumn::make('tanggal')->date('d M Y')->sortable(), TextColumn::make('tema')->searchable()->limit(40)->placeholder('-'),
            TextColumn::make('tempat')->placeholder('-'), TextColumn::make('pos.nama_pos')->label('Pos')->placeholder('-'),
            TextColumn::make('kapasitas')->numeric(), TextColumn::make('pendaftaran_count')->counts('pendaftaran')->label('Pendaftar'),
            TextColumn::make('status')->badge()->color(fn (string $state) => match ($state) {'terjadwal' => 'info', 'berlangsung' => 'warning', 'selesai' => 'success', default => 'gray'}),
        ])->filters([SelectFilter::make('status')->options(['terjadwal' => 'Terjadwal', 'berlangsung' => 'Berlangsung', 'selesai' => 'Selesai', 'dibatalkan' => 'Dibatalkan'])])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManageKegiatanEdukasis::route('/')]; }
}
