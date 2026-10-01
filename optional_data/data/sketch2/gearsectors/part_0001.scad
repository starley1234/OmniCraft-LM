$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[51.158, 0], [52.174, 2.401], [53.099, 4.837], [53.933, 7.306], [59.982, 10.328], [61.682, 19.592], [57.101, 24.564], [57.198, 27.169], [57.198, 29.775], [57.101, 32.38], [61.682, 37.352], [59.982, 46.616], [53.933, 49.638], [53.099, 52.107], [52.174, 54.543], [51.158, 56.944], [0, 34.166], [0.28, 33.489], [0.525, 32.798], [0.733, 32.095], [0.904, 31.383], [1.038, 30.662], [1.133, 29.935], [1.191, 29.205], [1.21, 28.472], [1.191, 27.739], [1.133, 27.009], [1.038, 26.282], [0.904, 25.561], [0.733, 24.849], [0.525, 24.146], [0.28, 23.455], [0, 22.778]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
