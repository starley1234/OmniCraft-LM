$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[32, 0], [31.412, 6.106], [29.67, 11.987], [24.107, 9.74], [22.118, 13.668], [19.494, 17.204], [16.312, 20.247], [12.662, 22.709], [8.648, 24.519], [4.387, 25.627], [0, 26], [0, 18], [5.562, 17.119], [10.58, 14.562], [14.562, 10.58], [17.119, 5.562], [18, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
