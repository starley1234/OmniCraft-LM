$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.714, 0], [35.37, 1.542], [35.974, 3.105], [41.237, 3.013], [42.222, 6.325], [37.763, 9.123], [38.112, 10.762], [38.405, 12.412], [43.589, 13.329], [43.921, 16.769], [39.009, 18.662], [39.037, 20.337], [39.009, 22.012], [43.921, 23.905], [43.589, 27.345], [38.405, 28.262], [38.112, 29.912], [37.763, 31.551], [42.222, 34.349], [41.237, 37.661], [35.974, 37.569], [35.37, 39.132], [34.714, 40.674], [0, 25.218], [0.24, 24.637], [0.45, 24.045], [0.628, 23.443], [0.775, 22.832], [0.889, 22.214], [0.971, 21.591], [1.021, 20.965], [1.037, 20.337], [1.021, 19.709], [0.971, 19.083], [0.889, 18.46], [0.775, 17.842], [0.628, 17.231], [0.45, 16.629], [0.24, 16.037], [0, 15.456]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
