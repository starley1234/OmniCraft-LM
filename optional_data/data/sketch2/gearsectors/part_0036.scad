$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[44.55, 0], [45.644, 2.262], [46.642, 4.569], [47.543, 6.915], [56.537, 8.781], [58.485, 18.187], [50.972, 23.472], [51.077, 25.982], [51.077, 28.496], [50.972, 31.006], [58.485, 36.291], [56.537, 45.697], [47.543, 47.563], [46.642, 49.909], [45.644, 52.216], [44.55, 54.478], [0, 31.779], [0.225, 31.306], [0.426, 30.823], [0.601, 30.329], [0.749, 29.827], [0.871, 29.318], [0.967, 28.803], [1.035, 28.284], [1.076, 27.762], [1.09, 27.239], [1.076, 26.716], [1.035, 26.194], [0.967, 25.675], [0.871, 25.16], [0.749, 24.651], [0.601, 24.149], [0.426, 23.655], [0.225, 23.172], [0, 22.699]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
