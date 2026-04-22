<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Login Alert - BABYMONSTER</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            background: #0f0f1a;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid rgba(0, 255, 255, 0.2);
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }
        .header {
            background: linear-gradient(135deg, #00d4ff 0%, #ff2d4a 100%);
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            color: white;
            margin: 0;
            font-size: 28px;
        }
        .content {
            padding: 30px;
            color: #e0e0e0;
        }
        .alert-box {
            background: rgba(255, 45, 74, 0.1);
            border-left: 3px solid #ff2d4a;
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
        }
        .info-box {
            background: rgba(0, 255, 255, 0.05);
            border: 1px solid rgba(0, 255, 255, 0.2);
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
        }
        .info-row {
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .label {
            font-weight: bold;
            color: #00d4ff;
            display: inline-block;
            width: 120px;
        }
        .button {
            display: inline-block;
            background: linear-gradient(135deg, #00d4ff 0%, #ff2d4a 100%);
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 25px;
            margin: 20px 0;
            font-weight: bold;
        }
        .footer {
            background: rgba(0,0,0,0.3);
            padding: 20px;
            text-align: center;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔐 New Login Detected</h1>
        </div>
        <div class="content">
            <h2>Hi {{ $user->name }}! 👋</h2>

            <div class="alert-box">
                <strong>⚠️ A new login to your account was detected</strong>
            </div>

            <div class="info-box">
                <h3>📋 Login Details:</h3>
                <div class="info-row">
                    <span class="label">Time:</span>
                    <span>{{ $loginHistory->login_at->format('F j, Y g:i A') }}</span>
                </div>
                <div class="info-row">
                    <span class="label">IP Address:</span>
                    <span>{{ $loginHistory->ip_address }}</span>
                </div>
                <div class="info-row">
                    <span class="label">Device:</span>
                    <span>{{ ucfirst($loginHistory->device_type) }}</span>
                </div>
                <div class="info-row">
                    <span class="label">Browser:</span>
                    <span>{{ $loginHistory->browser }}</span>
                </div>
                <div class="info-row">
                    <span class="label">OS:</span>
                    <span>{{ $loginHistory->os }}</span>
                </div>
                <div class="info-row">
                    <span class="label">Provider:</span>
                    <span>{{ ucfirst($loginHistory->provider) }}</span>
                </div>
            </div>

            <p>If this was you, you can safely ignore this email.</p>
            <p><strong>If this wasn't you, please secure your account immediately!</strong></p>

            <center>
                <a href="{{ config('app.frontend_url') }}/profile" class="button">View Account Activity →</a>
            </center>
        </div>
        <div class="footer">
            <p>© 2026 BABYMONSTER Fan Page. All rights reserved.</p>
            <p>This is an automated security notification.</p>
        </div>
    </div>
</body>
</html>
