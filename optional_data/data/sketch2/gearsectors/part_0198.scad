$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[66.574, 0], [67.312, 2.402], [67.976, 4.826], [74.418, 5.961], [75.43, 11.268], [69.858, 14.694], [70.134, 17.192], [70.331, 19.698], [76.447, 22.02], [76.447, 27.422], [70.331, 29.744], [70.134, 32.25], [69.858, 34.748], [75.43, 38.174], [74.418, 43.481], [67.976, 44.616], [67.312, 47.04], [66.574, 49.442], [0, 27.811], [0.148, 27.309], [0.27, 26.8], [0.366, 26.285], [0.434, 25.766], [0.475, 25.244], [0.489, 24.721], [0.475, 24.198], [0.434, 23.676], [0.366, 23.157], [0.27, 22.642], [0.148, 22.133], [0, 21.631]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
