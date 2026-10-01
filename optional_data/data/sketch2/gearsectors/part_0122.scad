$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.641, 0], [35.758, 2.042], [36.778, 4.133], [37.699, 6.27], [43.794, 8.461], [45.736, 16.87], [41.218, 21.512], [41.326, 23.837], [41.326, 26.163], [41.218, 28.488], [45.736, 33.13], [43.794, 41.539], [37.699, 43.73], [36.778, 45.867], [35.758, 47.958], [34.641, 50], [0, 30], [0.25, 29.54], [0.475, 29.067], [0.676, 28.584], [0.851, 28.09], [0.999, 27.588], [1.121, 27.079], [1.217, 26.564], [1.285, 26.045], [1.326, 25.523], [1.34, 25], [1.326, 24.477], [1.285, 23.955], [1.217, 23.436], [1.121, 22.921], [0.999, 22.412], [0.851, 21.91], [0.676, 21.416], [0.475, 20.933], [0.25, 20.46], [0, 20]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
