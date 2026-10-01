$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[43.748, 0], [44.608, 2.891], [51.759, 2.593], [52.438, 5.676], [45.824, 8.411], [46.258, 11.395], [53.378, 12.131], [53.606, 15.28], [46.666, 17.033], [46.666, 20.049], [53.606, 21.802], [53.378, 24.951], [46.258, 25.687], [45.824, 28.671], [52.438, 31.406], [51.759, 34.489], [44.608, 34.191], [43.748, 37.082], [0, 22.867], [0.208, 22.164], [0.379, 21.452], [0.513, 20.731], [0.608, 20.004], [0.666, 19.274], [0.685, 18.541], [0.666, 17.808], [0.608, 17.078], [0.513, 16.351], [0.379, 15.63], [0.208, 14.918], [0, 14.215]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
