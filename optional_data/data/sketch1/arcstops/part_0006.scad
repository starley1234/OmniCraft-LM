$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[32, 0], [31.412, 6.106], [29.67, 11.987], [24.107, 9.74], [22.118, 13.668], [19.494, 17.204], [16.312, 20.247], [12.662, 22.709], [8.648, 24.519], [4.387, 25.627], [0, 26], [0, 16], [4.944, 15.217], [9.405, 12.944], [12.944, 9.405], [15.217, 4.944], [16, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
