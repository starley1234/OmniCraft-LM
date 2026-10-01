$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[42.768, 0], [43.862, 2.262], [44.86, 4.569], [45.761, 6.915], [54.755, 8.781], [56.703, 18.187], [49.19, 23.472], [49.295, 25.982], [49.295, 28.496], [49.19, 31.006], [56.703, 36.291], [54.755, 45.697], [45.761, 47.563], [44.86, 49.909], [43.862, 52.216], [42.768, 54.478], [0, 32.687], [0.271, 32.12], [0.511, 31.539], [0.721, 30.947], [0.899, 30.345], [1.046, 29.734], [1.16, 29.116], [1.242, 28.493], [1.292, 27.867], [1.308, 27.239], [1.292, 26.611], [1.242, 25.985], [1.16, 25.362], [1.046, 24.744], [0.899, 24.133], [0.721, 23.531], [0.511, 22.939], [0.271, 22.358], [0, 21.791]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
