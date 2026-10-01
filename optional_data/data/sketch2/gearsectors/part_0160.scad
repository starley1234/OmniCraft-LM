$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[54.813, 0], [55.731, 2.159], [56.576, 4.347], [63.945, 4.218], [65.324, 8.855], [59.082, 12.773], [59.57, 15.067], [59.98, 17.377], [67.237, 18.661], [67.703, 23.476], [60.826, 26.127], [60.865, 28.472], [60.826, 30.817], [67.703, 33.468], [67.237, 38.283], [59.98, 39.567], [59.57, 41.877], [59.082, 44.171], [65.324, 48.089], [63.945, 52.726], [56.576, 52.597], [55.731, 54.785], [54.813, 56.944], [0, 32.539], [0.201, 32.056], [0.376, 31.562], [0.524, 31.06], [0.646, 30.551], [0.742, 30.036], [0.81, 29.517], [0.851, 28.995], [0.865, 28.472], [0.851, 27.949], [0.81, 27.427], [0.742, 26.908], [0.646, 26.393], [0.524, 25.884], [0.376, 25.382], [0.201, 24.888], [0, 24.405]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
