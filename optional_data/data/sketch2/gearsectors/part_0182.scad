$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.238, 0], [34.7, 1.501], [35.114, 3.017], [41.336, 3.235], [41.996, 6.691], [36.291, 9.184], [36.463, 10.746], [36.586, 12.311], [42.657, 13.692], [42.657, 17.21], [36.586, 18.591], [36.463, 20.156], [36.291, 21.718], [41.996, 24.211], [41.336, 27.667], [35.114, 27.885], [34.7, 29.401], [34.238, 30.902], [0, 19.777], [0.208, 19.074], [0.379, 18.362], [0.513, 17.641], [0.608, 16.914], [0.666, 16.184], [0.685, 15.451], [0.666, 14.718], [0.608, 13.988], [0.513, 13.261], [0.379, 12.54], [0.208, 11.828], [0, 11.125]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
