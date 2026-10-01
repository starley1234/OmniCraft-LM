$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[36.14, 0], [36.602, 1.501], [37.016, 3.017], [43.238, 3.235], [43.898, 6.691], [38.193, 9.184], [38.365, 10.746], [38.488, 12.311], [44.559, 13.692], [44.559, 17.21], [38.488, 18.591], [38.365, 20.156], [38.193, 21.718], [43.898, 24.211], [43.238, 27.667], [37.016, 27.885], [36.602, 29.401], [36.14, 30.902], [0, 19.159], [0.178, 18.557], [0.325, 17.946], [0.439, 17.328], [0.521, 16.705], [0.571, 16.079], [0.587, 15.451], [0.571, 14.823], [0.521, 14.197], [0.439, 13.574], [0.325, 12.956], [0.178, 12.345], [0, 11.743]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
