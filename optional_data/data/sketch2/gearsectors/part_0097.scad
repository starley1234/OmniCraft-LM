$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[51.678, 0], [52.955, 2.639], [54.119, 5.33], [55.17, 8.067], [62.455, 11.15], [64.632, 21.662], [59.17, 27.384], [59.293, 30.313], [59.293, 33.245], [59.17, 36.174], [64.632, 41.896], [62.455, 52.408], [55.17, 55.491], [54.119, 58.228], [52.955, 60.919], [51.678, 63.558], [0, 37.227], [0.271, 36.66], [0.511, 36.079], [0.721, 35.487], [0.899, 34.885], [1.046, 34.274], [1.16, 33.656], [1.242, 33.033], [1.292, 32.407], [1.308, 31.779], [1.292, 31.151], [1.242, 30.525], [1.16, 29.902], [1.046, 29.284], [0.899, 28.673], [0.721, 28.071], [0.511, 27.479], [0.271, 26.898], [0, 26.331]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
