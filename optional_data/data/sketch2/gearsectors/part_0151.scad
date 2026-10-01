$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[55.161, 0], [55.808, 2.102], [56.388, 4.223], [62.757, 5.052], [63.651, 9.742], [58.035, 12.858], [58.276, 15.043], [58.449, 17.236], [64.549, 19.244], [64.549, 24.018], [58.449, 26.026], [58.276, 28.219], [58.035, 30.404], [63.651, 33.52], [62.757, 38.21], [56.388, 39.039], [55.808, 41.16], [55.161, 43.262], [0, 25.339], [0.178, 24.737], [0.325, 24.126], [0.439, 23.508], [0.521, 22.885], [0.571, 22.259], [0.587, 21.631], [0.571, 21.003], [0.521, 20.377], [0.439, 19.754], [0.325, 19.136], [0.178, 18.525], [0, 17.923]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
