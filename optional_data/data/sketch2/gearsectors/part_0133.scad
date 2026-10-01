$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.238, 0], [34.954, 2.409], [41.076, 2.122], [41.643, 4.699], [35.967, 7.009], [36.329, 9.496], [42.428, 10.093], [42.619, 12.725], [36.669, 14.194], [36.669, 16.708], [42.619, 18.177], [42.428, 20.809], [36.329, 21.406], [35.967, 23.893], [41.643, 26.203], [41.076, 28.78], [34.954, 28.493], [34.238, 30.902], [0, 19.777], [0.208, 19.074], [0.379, 18.362], [0.513, 17.641], [0.608, 16.914], [0.666, 16.184], [0.685, 15.451], [0.666, 14.718], [0.608, 13.988], [0.513, 13.261], [0.379, 12.54], [0.208, 11.828], [0, 11.125]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
