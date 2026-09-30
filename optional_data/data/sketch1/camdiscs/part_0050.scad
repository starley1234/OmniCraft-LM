$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 8.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[42, 21.148], [41.354, 26.462], [39.371, 31.589], [35.962, 36.235], [31.107, 39.944], [25, 42.148], [18.129, 42.296], [11.275, 40.039], [5.393, 35.393], [1.41, 28.813], [0, 21.148], [1.41, 13.483], [5.393, 6.902], [11.275, 2.256], [18.129, 0], [25, 0.148], [31.107, 2.351], [35.962, 6.061], [39.371, 10.706], [41.354, 15.834]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
