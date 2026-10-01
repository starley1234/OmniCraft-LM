$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.238, 0], [34.843, 2.005], [35.364, 4.033], [42.731, 5.064], [43.459, 10.384], [36.641, 13.357], [36.685, 15.451], [36.641, 17.545], [43.459, 20.518], [42.731, 25.838], [35.364, 26.869], [34.843, 28.897], [34.238, 30.902], [0, 19.777], [0.208, 19.074], [0.379, 18.362], [0.513, 17.641], [0.608, 16.914], [0.666, 16.184], [0.685, 15.451], [0.666, 14.718], [0.608, 13.988], [0.513, 13.261], [0.379, 12.54], [0.208, 11.828], [0, 11.125]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
