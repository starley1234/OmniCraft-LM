$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 6.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[36, 16.167], [35.473, 20.417], [34.128, 24.604], [31.954, 28.809], [28.574, 32.753], [23.799, 35.634], [18.066, 36.572], [12.288, 35.243], [7.248, 32.038], [3.334, 27.521], [0.851, 22.084], [0, 16.167], [0.931, 10.275], [3.843, 5.141], [8.379, 1.602], [13.62, 0.006], [18.675, 0], [23.19, 0.938], [27.243, 2.496], [30.823, 4.831], [33.619, 8.058], [35.392, 11.941]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
