$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[36.542, 0], [37.198, 1.542], [37.802, 3.105], [45.913, 2.068], [46.951, 5.56], [39.591, 9.123], [39.94, 10.762], [40.233, 12.412], [48.392, 12.947], [48.743, 16.574], [40.837, 18.662], [40.865, 20.337], [40.837, 22.012], [48.743, 24.1], [48.392, 27.727], [40.233, 28.262], [39.94, 29.912], [39.591, 31.551], [46.951, 35.114], [45.913, 38.606], [37.802, 37.569], [37.198, 39.132], [36.542, 40.674], [0, 24.404], [0.201, 23.921], [0.376, 23.427], [0.524, 22.925], [0.646, 22.416], [0.742, 21.901], [0.81, 21.382], [0.851, 20.86], [0.865, 20.337], [0.851, 19.814], [0.81, 19.292], [0.742, 18.773], [0.646, 18.258], [0.524, 17.749], [0.376, 17.247], [0.201, 16.753], [0, 16.27]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
