$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[38.042, 0], [38.758, 2.409], [43.908, 2.36], [44.466, 4.891], [39.771, 7.009], [40.133, 9.496], [45.237, 10.189], [45.424, 12.774], [40.473, 14.194], [40.473, 16.708], [45.424, 18.128], [45.237, 20.713], [40.133, 21.406], [39.771, 23.893], [44.466, 26.011], [43.908, 28.542], [38.758, 28.493], [38.042, 30.902], [0, 18.541], [0.148, 18.039], [0.27, 17.53], [0.366, 17.015], [0.434, 16.496], [0.475, 15.974], [0.489, 15.451], [0.475, 14.928], [0.434, 14.406], [0.366, 13.887], [0.27, 13.372], [0.148, 12.863], [0, 12.361]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
