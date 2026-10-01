$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[45.65, 0], [46.51, 2.891], [52.69, 2.831], [53.359, 5.868], [47.726, 8.411], [48.16, 11.395], [54.284, 12.227], [54.509, 15.328], [48.568, 17.033], [48.568, 20.049], [54.509, 21.754], [54.284, 24.855], [48.16, 25.687], [47.726, 28.671], [53.359, 31.214], [52.69, 34.251], [46.51, 34.191], [45.65, 37.082], [0, 22.249], [0.178, 21.647], [0.325, 21.036], [0.439, 20.418], [0.521, 19.795], [0.571, 19.169], [0.587, 18.541], [0.571, 17.913], [0.521, 17.287], [0.439, 16.664], [0.325, 16.046], [0.178, 15.435], [0, 14.833]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
