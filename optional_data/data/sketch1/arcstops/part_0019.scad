$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[56.569, 0], [55.908, 6.869], [53.948, 13.486], [50.239, 11.987], [45.981, 19.449], [39.891, 25.508], [32.409, 29.729], [24.073, 31.808], [15.485, 31.593], [7.263, 29.102], [0, 24.513], [5.142, 18.385], [14.763, 23.287], [25.559, 23.476], [35.345, 18.912], [42.14, 10.521], [44.569, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
