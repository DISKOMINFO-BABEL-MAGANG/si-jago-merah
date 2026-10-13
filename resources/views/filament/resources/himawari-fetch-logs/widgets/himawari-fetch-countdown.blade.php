<x-filament-widgets::widget>

    <style>
        .himawari-hud {
            position: relative;
            overflow: hidden;
            width: 100%;
            min-height: 260px;
            background:
                radial-gradient(circle at 15% 50%, rgba(255, 106, 0, .12), transparent 32%),
                radial-gradient(circle at 85% 50%, rgba(255, 42, 109, .10), transparent 32%),
                #030306;
            border: 1px solid rgba(255, 120, 0, .45);
            border-radius: 18px;
            box-shadow:
                0 0 30px rgba(255, 100, 0, .08),
                inset 0 0 40px rgba(255, 70, 0, .03);
            font-family: "Courier New", monospace;
        }

        /* Neon border */
        .himawari-hud::before {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 18px;
            padding: 1px;
            background: linear-gradient(
                90deg,
                #ff7700,
                #ff2a6d,
                #ffaa00,
                #ff5500
            );
            -webkit-mask:
                linear-gradient(#fff 0 0) content-box,
                linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: .75;
            pointer-events: none;
        }

        /* Grid */
        .himawari-grid {
            position: absolute;
            inset: 0;
            opacity: .04;
            background-image:
                linear-gradient(rgba(255, 130, 0, .8) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 130, 0, .8) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
        }

        .himawari-content {
            position: relative;
            z-index: 2;
            display: grid;
            grid-template-columns: 1.1fr 1.2fr .8fr;
            gap: 28px;
            align-items: center;
            padding: 32px;
        }

        /* LEFT */
        .himawari-status {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 7px 13px;
            border: 1px solid rgba(255, 160, 0, .35);
            border-radius: 30px;
            background: rgba(255, 140, 0, .05);
            color: #ffaa33;
            font-size: 10px;
            font-weight: bold;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        .himawari-status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #ff9900;
            box-shadow: 0 0 12px #ff9900;
            animation: himawari-pulse 1.5s infinite;
        }

        @keyframes himawari-pulse {
            0%, 100% {
                opacity: 1;
                box-shadow: 0 0 10px #ff9900;
            }

            50% {
                opacity: .4;
                box-shadow: 0 0 20px #ff5500;
            }
        }

        .himawari-title {
            margin-top: 18px;
            font-family: Arial, sans-serif;
            font-size: 34px;
            line-height: 1;
            font-weight: 900;
            letter-spacing: -1px;
            color: #ffffff;
        }

        .himawari-title span {
            display: block;
            margin-top: 5px;
            font-family: "Courier New", monospace;
            font-style: italic;
            color: #ff8c00;
            text-shadow: 0 0 15px rgba(255, 140, 0, .45);
        }

        .himawari-description {
            max-width: 390px;
            margin-top: 18px;
            color: #9ea8b6;
            font-family: Arial, sans-serif;
            font-size: 13px;
            line-height: 1.7;
        }

        .himawari-description strong {
            color: #ffeedd;
        }

        /* CENTER */
        .himawari-countdown-box {
            position: relative;
            padding: 25px 25px 20px;
            border: 1px solid rgba(255, 120, 0, .35);
            border-radius: 13px;
            background: rgba(18, 9, 4, .85);
            box-shadow:
                inset 0 0 25px rgba(255, 90, 0, .04),
                0 0 25px rgba(255, 80, 0, .05);
        }

        .himawari-countdown-box::before,
        .himawari-countdown-box::after {
            content: "";
            position: absolute;
            width: 18px;
            height: 18px;
        }

        .himawari-countdown-box::before {
            top: -1px;
            left: -1px;
            border-top: 2px solid #ff7700;
            border-left: 2px solid #ff7700;
        }

        .himawari-countdown-box::after {
            right: -1px;
            bottom: -1px;
            border-right: 2px solid #ff2a6d;
            border-bottom: 2px solid #ff2a6d;
        }

        .himawari-countdown-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: #9a887a;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 4px;
        }

        .himawari-countdown-label-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: #ff7700;
            box-shadow: 0 0 9px #ff7700;
        }

        .himawari-time {
            margin-top: 14px;
            text-align: center;
            font-family: "Courier New", monospace;
            font-size: clamp(34px, 4vw, 52px);
            font-weight: 900;
            font-style: italic;
            letter-spacing: 4px;
            color: #ffffff;
            text-shadow:
                0 0 10px rgba(255, 150, 50, .55),
                0 0 25px rgba(255, 80, 0, .25);
        }

        .himawari-units {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            margin-top: 4px;
            color: #68574e;
            font-size: 8px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .himawari-progress-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 22px;
        }

        .himawari-progress {
            flex: 1;
            height: 6px;
            overflow: hidden;
            border-radius: 10px;
            background: #1e130c;
        }

        .himawari-progress-bar {
            height: 100%;
            border-radius: 10px;
            background: linear-gradient(
                90deg,
                #ff7700,
                #ff2a6d,
                #ffaa00
            );
            box-shadow:
                0 0 10px rgba(255, 120, 0, .7),
                0 0 20px rgba(255, 50, 100, .3);
            transition: width 1s linear;
        }

        .himawari-progress-value {
            width: 40px;
            color: #ff9933;
            font-size: 10px;
            font-weight: bold;
            text-align: right;
        }

        /* RIGHT */
        .himawari-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .himawari-info-card {
            padding: 15px 16px;
            border: 1px solid rgba(200, 100, 40, .2);
            border-radius: 11px;
            background: rgba(22, 11, 6, .7);
        }

        .himawari-info-label {
            color: #7d6b5e;
            font-size: 9px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .himawari-info-value {
            margin-top: 5px;
            color: #ffffff;
            font-size: 16px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .himawari-info-value.amber {
            color: #ff9d33;
            text-shadow: 0 0 10px rgba(255, 140, 0, .35);
        }

        .himawari-info-value.crimson {
            color: #ff5e85;
            text-shadow: 0 0 10px rgba(255, 42, 109, .35);
        }

        .himawari-running {
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 12px 15px;
            border: 1px solid rgba(255, 170, 0, .25);
            border-radius: 10px;
            color: #ffaa33;
            background: rgba(255, 140, 0, .04);
            font-size: 9px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .himawari-running-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #ff9900;
            box-shadow: 0 0 10px #ff9900;
        }

        /* Bottom */
        .himawari-footer {
            position: relative;
            z-index: 2;
            display: flex;
            justify-content: space-between;
            padding: 0 32px 17px;
            color: #4b392e;
            font-size: 8px;
            letter-spacing: 3px;
        }

        /* Responsive */
        @media (max-width: 1000px) {
            .himawari-content {
                grid-template-columns: 1fr;
            }

            .himawari-info {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
            }

            .himawari-running {
                grid-column: span 2;
            }
        }

        @media (max-width: 640px) {
            .himawari-content {
                padding: 22px;
            }

            .himawari-title {
                font-size: 27px;
            }

            .himawari-info {
                grid-template-columns: 1fr;
            }

            .himawari-running {
                grid-column: auto;
            }

            .himawari-footer {
                padding: 0 22px 15px;
            }
        }
    </style>

    <div
        x-data="{
            target: new Date('{{ $this->getNextFetchTime() }}').getTime(),
            remaining: 0,
            total: 600000,

            updateCountdown() {
                const now = new Date().getTime();

                if (now >= this.target) {
                    const next = new Date();

                    next.setSeconds(0, 0);
                    next.setMinutes(
                        Math.ceil((next.getMinutes() + 1) / 10) * 10
                    );

                    this.target = next.getTime();
                }

                this.remaining = Math.max(0, this.target - now);
            },

            formatTime() {
                let totalSeconds =
                    Math.floor(this.remaining / 1000);

                const hours =
                    Math.floor(totalSeconds / 3600);

                totalSeconds %= 3600;

                const minutes =
                    Math.floor(totalSeconds / 60);

                const seconds =
                    totalSeconds % 60;

                return [
                    String(hours).padStart(2, '0'),
                    String(minutes).padStart(2, '0'),
                    String(seconds).padStart(2, '0')
                ].join(' : ');
            },

            progress() {
                return Math.min(
                    100,
                    Math.max(
                        0,
                        100 - (this.remaining / this.total * 100)
                    )
                );
            },

            nextFetchLabel() {
                return new Date(this.target).toLocaleTimeString('id-ID', {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false,
                    timeZone: 'Asia/Jakarta'
                }) + ' WIB';
            }
        }"
        x-init="
            updateCountdown();
            setInterval(() => updateCountdown(), 1000);
        "
    >

        <div class="himawari-hud">

            <div class="himawari-grid"></div>

            <div class="himawari-content">

                {{-- LEFT --}}
                <div>

                    <div class="himawari-status">
                        <span class="himawari-status-dot"></span>
                        Sistem Otomatis
                    </div>

                    <div class="himawari-title">
                        Sinkronisasi
                        <span>Himawari-9</span>
                    </div>

                    <div class="himawari-description">
                        Pengambilan data citra dan deteksi hotspot dari satelit
                        <strong>Himawari-9 (JMA / NOAA)</strong>
                        berikutnya akan dilakukan secara otomatis oleh sistem.
                    </div>

                </div>

                {{-- CENTER --}}
                <div class="himawari-countdown-box">

                    <div class="himawari-countdown-label">
                        <span class="himawari-countdown-label-dot"></span>
                        Waktu Tersisa
                    </div>

                    <div
                        class="himawari-time"
                        x-text="formatTime()"
                    ></div>

                    <div class="himawari-units">
                        <span>Jam</span>
                        <span>Menit</span>
                        <span>Detik</span>
                    </div>

                    <div class="himawari-progress-row">

                        <div class="himawari-progress">
                            <div
                                class="himawari-progress-bar"
                                :style="`width: ${progress()}%`"
                            ></div>
                        </div>

                        <div
                            class="himawari-progress-value"
                            x-text="Math.round(progress()) + '%'"
                        ></div>

                    </div>

                </div>

                {{-- RIGHT --}}
                <div class="himawari-info">

                    <div class="himawari-info-card">

                        <div class="himawari-info-label">
                            Jadwal Berikutnya
                        </div>

                        <div
                            class="himawari-info-value amber"
                            x-text="nextFetchLabel()"
                        ></div>

                    </div>

                    <div class="himawari-info-card">

                        <div class="himawari-info-label">
                            Sumber Satelit
                        </div>

                        <div class="himawari-info-value crimson">
                            Himawari-9 / AHI
                        </div>

                    </div>

                    <div class="himawari-running">

                        <span class="himawari-running-dot"></span>

                        Sistem berjalan otomatis

                    </div>

                </div>

            </div>

            <div class="himawari-footer">

                <span>
                    SI JAGO MERAH // HIMAWARI-9 HOTSPOT MONITORING
                </span>

                <span>
                    AUTO SYNC (10 MIN)
                </span>

            </div>

        </div>

    </div>

</x-filament-widgets::widget>
