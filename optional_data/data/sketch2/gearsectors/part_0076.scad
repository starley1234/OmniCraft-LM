$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[63.949, 0], [65.109, 2.743], [66.167, 5.528], [67.12, 8.349], [76.251, 11.25], [78.246, 22.119], [70.74, 28.073], [70.851, 31.05], [70.851, 34.028], [70.74, 37.005], [78.246, 42.959], [76.251, 53.828], [67.12, 56.729], [66.167, 59.55], [65.109, 62.335], [63.949, 65.078], [0, 36.606], [0.201, 36.123], [0.376, 35.629], [0.524, 35.127], [0.646, 34.618], [0.742, 34.103], [0.81, 33.584], [0.851, 33.062], [0.865, 32.539], [0.851, 32.016], [0.81, 31.494], [0.742, 30.975], [0.646, 30.46], [0.524, 29.951], [0.376, 29.449], [0.201, 28.955], [0, 28.472]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
