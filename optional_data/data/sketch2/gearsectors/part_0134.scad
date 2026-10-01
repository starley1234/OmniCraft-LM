$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[54.813, 0], [55.949, 2.703], [56.971, 5.451], [65.536, 5.928], [67.161, 12.255], [59.885, 16.798], [60.313, 19.699], [60.62, 22.615], [68.797, 25.206], [68.797, 31.738], [60.62, 34.329], [60.313, 37.245], [59.885, 40.146], [67.161, 44.689], [65.536, 51.016], [56.971, 51.493], [55.949, 54.241], [54.813, 56.944], [0, 32.539], [0.201, 32.056], [0.376, 31.562], [0.524, 31.06], [0.646, 30.551], [0.742, 30.036], [0.81, 29.517], [0.851, 28.995], [0.865, 28.472], [0.851, 27.949], [0.81, 27.427], [0.742, 26.908], [0.646, 26.393], [0.524, 25.884], [0.376, 25.382], [0.201, 24.888], [0, 24.405]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
