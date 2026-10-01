$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[55.161, 0], [56.008, 2.807], [56.738, 5.646], [65.281, 7.417], [66.278, 14.697], [58.526, 18.7], [58.587, 21.631], [58.526, 24.562], [66.278, 28.565], [65.281, 35.845], [56.738, 37.616], [56.008, 40.455], [55.161, 43.262], [0, 25.339], [0.178, 24.737], [0.325, 24.126], [0.439, 23.508], [0.521, 22.885], [0.571, 22.259], [0.587, 21.631], [0.571, 21.003], [0.521, 20.377], [0.439, 19.754], [0.325, 19.136], [0.178, 18.525], [0, 17.923]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
