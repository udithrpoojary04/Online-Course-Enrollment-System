<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate of Completion - Elite Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,700;1,600&family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f5;
            font-family: 'Montserrat', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .certificate-wrapper {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
            max-width: 1000px;
            width: 100%;
            position: relative;
        }

        .certificate-container {
            border: 12px solid #1a1a2e;
            padding: 60px 40px;
            text-align: center;
            position: relative;
            background: #fff;
            overflow: hidden;
            border-radius: 4px;
        }

        .certificate-container::before {
            content: '';
            position: absolute;
            top: 10px; left: 10px; right: 10px; bottom: 10px;
            border: 2px solid #d4af37;
            pointer-events: none;
        }

        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 15rem;
            color: rgba(212, 175, 55, 0.04);
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            white-space: nowrap;
            pointer-events: none;
            z-index: 1;
        }

        .cert-header {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 5px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .cert-subheader {
            font-size: 1.2rem;
            color: #d4af37;
            font-weight: 500;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin-bottom: 50px;
        }

        .cert-presented-to {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .cert-name {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            color: #d4af37;
            font-weight: 600;
            margin-bottom: 30px;
            border-bottom: 2px solid #eee;
            display: inline-block;
            padding: 0 40px 10px;
            font-style: italic;
        }

        .cert-description {
            font-size: 1.1rem;
            color: #555;
            max-width: 600px;
            margin: 0 auto 30px;
            line-height: 1.8;
        }

        .cert-course {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 60px;
        }

        .cert-footer {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 50px;
            padding: 0 50px;
        }

        .signature-block {
            text-align: center;
            width: 250px;
        }

        .signature-line {
            border-bottom: 2px solid #1a1a2e;
            margin-bottom: 10px;
            height: 40px;
        }

        .signature-name {
            font-weight: 700;
            color: #1a1a2e;
            font-size: 1.1rem;
            margin-bottom: 0;
        }

        .signature-title {
            font-size: 0.9rem;
            color: #777;
        }

        .badge-seal {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #d4af37, #f3e5ab, #d4af37);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px dashed #fff;
            box-shadow: 0 0 0 4px #d4af37, 0 10px 20px rgba(0,0,0,0.1);
            position: relative;
            margin: 0 auto;
        }
        
        .badge-seal::after {
            content: 'EA';
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .cert-id {
            position: absolute;
            bottom: 25px;
            right: 35px;
            font-size: 0.8rem;
            color: #aaa;
            font-family: monospace;
        }

        .print-btn-container {
            position: absolute;
            top: -60px;
            right: 0;
        }

        .btn-print {
            background: #1a1a2e;
            color: #d4af37;
            border: none;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(26,26,46,0.2);
            transition: all 0.3s ease;
        }
        
        .btn-print:hover {
            background: #d4af37;
            color: #1a1a2e;
            transform: translateY(-2px);
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            .certificate-wrapper {
                box-shadow: none;
                max-width: 100%;
                width: 100%;
                padding: 0;
            }
            .btn-print {
                display: none;
            }
            .cert-header, .cert-course, .signature-name {
                color: #000 !important;
            }
        }
    </style>
</head>
<body>

    <div class="certificate-wrapper">
        <div class="print-btn-container">
            <button class="btn btn-print" onclick="window.print()">🖨️ PRINT CERTIFICATE</button>
        </div>
        
        <div class="certificate-container">
            <div class="watermark">ELITE</div>
            
            <div style="position: relative; z-index: 2;">
                <div class="cert-header">Certificate</div>
                <div class="cert-subheader">of Completion</div>
                
                <div class="cert-presented-to">This is proudly presented to</div>
                
                <div class="cert-name">${studentName}</div>
                
                <div class="cert-description">
                    For successfully fulfilling all requirements and demonstrating exceptional 
                    proficiency in the coursework and final assessments of the curriculum.
                </div>
                
                <div class="cert-course">${courseTitle}</div>
                
                <div class="cert-footer">
                    <div class="signature-block">
                        <div class="signature-line">
                            <span style="font-family: 'Playfair Display', serif; font-size: 1.5rem; font-style: italic; color: #333;">${instructorName}</span>
                        </div>
                        <p class="signature-name">${instructorName}</p>
                        <p class="signature-title">Course Instructor</p>
                    </div>
                    
                    <div class="badge-seal"></div>
                    
                    <div class="signature-block">
                        <div class="signature-line" style="display: flex; align-items: flex-end; justify-content: center; padding-bottom: 5px;">
                            <span style="font-family: 'Montserrat', sans-serif; font-size: 1.1rem; color: #333;">${issueDate}</span>
                        </div>
                        <p class="signature-name">Date of Issue</p>
                        <p class="signature-title">Elite Academy</p>
                    </div>
                </div>
            </div>
            
            <div class="cert-id">ID: ${certificateId}</div>
        </div>
    </div>

</body>
</html>
