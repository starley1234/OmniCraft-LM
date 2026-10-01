$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.302, 0], [44.8, 2.761], [46.153, 5.596], [53.89, 5.989], [56.057, 12.659], [50.029, 17.525], [50.601, 20.614], [51.011, 23.728], [58.248, 26.493], [58.248, 33.507], [51.011, 36.272], [50.601, 39.386], [50.029, 42.475], [56.057, 47.341], [53.89, 54.011], [46.153, 54.404], [44.8, 57.239], [43.302, 60], [0, 35], [0.25, 34.54], [0.475, 34.067], [0.676, 33.584], [0.851, 33.09], [0.999, 32.588], [1.121, 32.079], [1.217, 31.564], [1.285, 31.045], [1.326, 30.523], [1.34, 30], [1.326, 29.477], [1.285, 28.955], [1.217, 28.436], [1.121, 27.921], [0.999, 27.412], [0.851, 26.91], [0.676, 26.416], [0.475, 25.933], [0.25, 25.46], [0, 25]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
