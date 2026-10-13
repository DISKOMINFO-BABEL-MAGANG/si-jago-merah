<x-filament-widgets::widget>

    <style>
        .hotspot-hud {
            position: relative;
            overflow: hidden;
            width: 100%;
            min-height: 260px;
            background:
                radial-gradient(circle at 15% 50%, rgba(0, 180, 255, .10), transparent 30%),
                radial-gradient(circle at 85% 50%, rgba(110, 60, 255, .10), transparent 30%),
                #020305;
            border: 1px solid rgba(0, 174, 255, .45);
            border-radius: 18px;
            box-shadow:
                0 0 30px rgba(0, 140, 255, .08),
                inset 0 0 40px rgba(0, 100, 255, .025);
            font-family: "Courier New", monospace;
        }

        /* Neon border */
        .hotspot-hud::before {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 18px;
            padding: 1px;
            background: linear-gradient(
                90deg,
                #00d9ff,
                #1478ff,
                #7b35ff,
                #00d9ff
            );
            -webkit-mask:
                linear-gradient(#fff 0 0) content-box,
                linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: .7;
            pointer-events: none;
        }

        /* Grid */
        .hotspot-grid {
            position: absolute;
            inset: 0;
            opacity: .035;
            background-image:
                linear-gradient(rgba(0, 200, 255, .8) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0, 200, 255, .8) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
        }

        .hotspot-content {
            position: relative;
            z-index: 2;
            display: grid;
            grid-template-columns: 1.1fr 1.2fr .8fr;
            gap: 28px;
            align-items: center;
            padding: 32px;
        }

        /* LEFT */

        .hotspot-status {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 7px 13px;
            border: 1px solid rgba(0, 255, 180, .3);
            border-radius: 30px;
            background: rgba(0, 255, 180, .04);
            color: #32f5ad;
            font-size: 10px;
            font-weight: bold;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        .hotspot-status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #21f59d;
            box-shadow: 0 0 12px #21f59d;
            animation: hotspot-pulse 1.5s infinite;
        }

        @keyframes hotspot-pulse {
            0%, 100% {
                opacity: 1;
                box-shadow: 0 0 10px #21f59d;
            }

            50% {
                opacity: .4;
                box-shadow: 0 0 20px #21f59d;
            }
        }

        .hotspot-title {
            margin-top: 18px;
            font-family: Arial, sans-serif;
            font-size: 34px;
            line-height: 1;
            font-weight: 900;
            letter-spacing: -1px;
            color: #ffffff;
        }

        .hotspot-title span {
            display: block;
            margin-top: 5px;
            font-family: "Courier New", monospace;
            font-style: italic;
            color: #00d9ff;
            text-shadow: 0 0 15px rgba(0, 217, 255, .4);
        }

        .hotspot-description {
            max-width: 390px;
            margin-top: 18px;
            color: #7f8da3;
            font-family: Arial, sans-serif;
            font-size: 13px;
            line-height: 1.7;
        }

        .hotspot-description strong {
            color: #d8e3f0;
        }

        /* CENTER */

        .hotspot-countdown-box {
            position: relative;
            padding: 25px 25px 20px;
            border: 1px solid rgba(40, 120, 255, .35);
            border-radius: 13px;
            background: rgba(3, 9, 20, .85);
            box-shadow:
                inset 0 0 25px rgba(0, 110, 255, .035),
                0 0 25px rgba(0, 100, 255, .04);
        }

        .hotspot-countdown-box::before,
        .hotspot-countdown-box::after {
            content: "";
            position: absolute;
            width: 18px;
            height: 18px;
        }

        .hotspot-countdown-box::before {
            top: -1px;
            left: -1px;
            border-top: 2px solid #00d9ff;
            border-left: 2px solid #00d9ff;
        }

        .hotspot-countdown-box::after {
            right: -1px;
            bottom: -1px;
            border-right: 2px solid #7b35ff;
            border-bottom: 2px solid #7b35ff;
        }

        .hotspot-countdown-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: #738198;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 4px;
        }

        .hotspot-countdown-label-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: #00d9ff;
            box-shadow: 0 0 9px #00d9ff;
        }

        .hotspot-time {
            margin-top: 14px;
            text-align: center;
            font-family: "Courier New", monospace;
            font-size: clamp(34px, 4vw, 52px);
            font-weight: 900;
            font-style: italic;
            letter-spacing: 4px;
            color: #ffffff;
            text-shadow:
                0 0 10px rgba(100, 180, 255, .5),
                0 0 25px rgba(70, 100, 255, .2);
        }

        .hotspot-units {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            margin-top: 4px;
            color: #465268;
            font-size: 8px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .hotspot-progress-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 22px;
        }

        .hotspot-progress {
            flex: 1;
            height: 6px;
            overflow: hidden;
            border-radius: 10px;
            background: #111827;
        }

        .hotspot-progress-bar {
            height: 100%;
            border-radius: 10px;
            background: linear-gradient(
                90deg,
                #00d9ff,
                #247bff,
                #9b42ff
            );
            box-shadow:
                0 0 10px rgba(0, 200, 255, .7),
                0 0 20px rgba(90, 50, 255, .3);
            transition: width 1s linear;
        }

        .hotspot-progress-value {
            width: 40px;
            color: #00d9ff;
            font-size: 10px;
            font-weight: bold;
            text-align: right;
        }

        /* RIGHT */

        .hotspot-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .hotspot-info-card {
            padding: 15px 16px;
            border: 1px solid rgba(60, 100, 180, .2);
            border-radius: 11px;
            background: rgba(5, 10, 22, .65);
        }

        .hotspot-info-label {
            color: #59677d;
            font-size: 9px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .hotspot-info-value {
            margin-top: 5px;
            color: #ffffff;
            font-size: 16px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .hotspot-info-value.blue {
            color: #3dbfff;
            text-shadow: 0 0 10px rgba(0, 180, 255, .3);
        }

        .hotspot-info-value.purple {
            color: #a879ff;
            text-shadow: 0 0 10px rgba(130, 70, 255, .3);
        }

        .hotspot-running {
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 12px 15px;
            border: 1px solid rgba(0, 255, 160, .18);
            border-radius: 10px;
            color: #31eaa5;
            background: rgba(0, 255, 160, .025);
            font-size: 9px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .hotspot-running-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #21f59d;
            box-shadow: 0 0 10px #21f59d;
        }

        /* Bottom */

        .hotspot-footer {
            position: relative;
            z-index: 2;
            display: flex;
            justify-content: space-between;
            padding: 0 32px 17px;
            color: #293344;
            font-size: 8px;
            letter-spacing: 3px;
        }

        /* Responsive */

        @media (max-width: 1000px) {
            .hotspot-content {
                grid-template-columns: 1fr;
            }

            .hotspot-info {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
            }

            .hotspot-running {
                grid-column: span 2;
            }
        }

        @media (max-width: 640px) {
            .hotspot-content {
                padding: 22px;
            }

            .hotspot-title {
                font-size: 27px;
            }

            .hotspot-info {
                grid-template-columns: 1fr;
            }

            .hotspot-running {
                grid-column: auto;
            }

            .hotspot-footer {
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

        <div class="hotspot-hud">

            <div class="hotspot-grid"></div>

            <div class="hotspot-content">

                {{-- LEFT --}}
                <div>

                    <div class="hotspot-status">
                        <span class="hotspot-status-dot"></span>
                        Sistem Otomatis
                    </div>

                    <div class="hotspot-title">
                        Sinkronisasi
                        <span>Hotspot</span>
                    </div>

                    <div class="hotspot-description">
                        Pengambilan data hotspot dari
                        <strong>NASA FIRMS</strong>
                        berikutnya akan dilakukan secara otomatis oleh sistem.
                    </div>

                </div>


                {{-- CENTER --}}
                <div class="hotspot-countdown-box">

                    <div class="hotspot-countdown-label">
                        <span class="hotspot-countdown-label-dot"></span>
                        Waktu Tersisa
                    </div>

                    <div
                        class="hotspot-time"
                        x-text="formatTime()"
                    ></div>

                    <div class="hotspot-units">
                        <span>Jam</span>
                        <span>Menit</span>
                        <span>Detik</span>
                    </div>

                    <div class="hotspot-progress-row">

                        <div class="hotspot-progress">
                            <div
                                class="hotspot-progress-bar"
                                :style="`width: ${progress()}%`"
                            ></div>
                        </div>

                        <div
                            class="hotspot-progress-value"
                            x-text="Math.round(progress()) + '%'"
                        ></div>

                    </div>

                </div>


                {{-- RIGHT --}}
                <div class="hotspot-info">

                    <div class="hotspot-info-card">

                        <div class="hotspot-info-label">
                            Jadwal Berikutnya
                        </div>

                        <div
                            class="hotspot-info-value blue"
                            x-text="nextFetchLabel()"
                        ></div>

                    </div>


                    <div class="hotspot-info-card">

                        <div class="hotspot-info-label">
                            Sumber Data
                        </div>

                        <div class="hotspot-info-value purple">
                            NASA FIRMS
                        </div>

                    </div>


                    <div class="hotspot-running">

                        <span class="hotspot-running-dot"></span>

                        Sistem berjalan otomatis

                    </div>

                </div>

            </div>


            <div class="hotspot-footer">

                <span>
                    SI JAGO MERAH // HOTSPOT MONITORING
                </span>

                <span>
                    AUTO SYNC
                </span>

            </div>

        </div>

    </div>

</x-filament-widgets::widget>