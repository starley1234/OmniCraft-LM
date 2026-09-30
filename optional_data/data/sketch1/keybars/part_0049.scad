$fn = 32;

// ----------------------------------------------------------------------
// Key bar: woodruff key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[20, 0], [19.659, 2.588], [18.66, 5], [17.071, 7.071], [15, 8.66], [12.588, 9.659], [10, 10], [7.412, 9.659], [5, 8.66], [2.929, 7.071], [1.34, 5], [0.341, 2.588], [0, 0]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
