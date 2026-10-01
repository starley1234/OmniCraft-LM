$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[53.259, 0], [54.106, 2.807], [54.836, 5.646], [60.429, 7.963], [61.388, 14.964], [56.624, 18.7], [56.685, 21.631], [56.624, 24.562], [61.388, 28.298], [60.429, 35.299], [54.836, 37.616], [54.106, 40.455], [53.259, 43.262], [0, 25.957], [0.208, 25.254], [0.379, 24.542], [0.513, 23.821], [0.608, 23.094], [0.666, 22.364], [0.685, 21.631], [0.666, 20.898], [0.608, 20.168], [0.513, 19.441], [0.379, 18.72], [0.208, 18.008], [0, 17.305]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
