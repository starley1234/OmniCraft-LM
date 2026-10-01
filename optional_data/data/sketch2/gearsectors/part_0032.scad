$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.748, 0], [44.475, 2.406], [45.1, 4.84], [51.58, 6.513], [52.424, 12.674], [46.632, 16.028], [46.685, 18.541], [46.632, 21.054], [52.424, 24.408], [51.58, 30.569], [45.1, 32.242], [44.475, 34.676], [43.748, 37.082], [0, 22.867], [0.208, 22.164], [0.379, 21.452], [0.513, 20.731], [0.608, 20.004], [0.666, 19.274], [0.685, 18.541], [0.666, 17.808], [0.608, 17.078], [0.513, 16.351], [0.379, 15.63], [0.208, 14.918], [0, 14.215]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
