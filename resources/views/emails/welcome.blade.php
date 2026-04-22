<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to BABYMONSTER Fan Page</title>
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
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        .content {
            padding: 30px;
            color: #e0e0e0;
        }
        .welcome-text {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .feature-box {
            background: rgba(0, 255, 255, 0.1);
            border-left: 3px solid #00d4ff;
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
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
            <h1>🎵 BABYMONSTER Fan Page 🎵</h1>
        </div>
        <div class="content">
            <h2>Welcome, {{ $user->name }}! 👋</h2>
            <p class="welcome-text">Thank you for joining the BABYMONSTER fan community!</p>

            <div class="feature-box">
                <strong>✨ What you can do:</strong>
                <ul style="margin-top: 10px;">
                    <li>🎬 Watch all BABYMONSTER MVs</li>
                    <li>💿 Explore albums and download audio</li>
                    <li>📰 Read latest news and updates</li>
                    <li>💬 Connect with other MONSTIEZ</li>
                </ul>
            </div>

            <p>We're excited to have you with us!</p>

            <center>
                <a href="{{ config('app.frontend_url') }}/main" class="button">Start Exploring →</a>
            </center>
        </div>
        <div class="footer">
            <p>© 2026 BABYMONSTER Fan Page. All rights reserved.</p>
            <p>You're receiving this because you joined our community.</p>
        </div>
    </div>
</body>
</html>
