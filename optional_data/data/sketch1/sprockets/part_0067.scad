$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 8 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[54.842, 23.797], [58.937, 35.09], [51.421, 43.4], [46.331, 54.281], [35.14, 54.842], [23.847, 58.937], [15.537, 51.421], [4.656, 46.331], [4.095, 35.14], [0, 23.847], [7.516, 15.537], [12.606, 4.656], [23.797, 4.095], [35.09, 0], [43.4, 7.516], [54.281, 12.606]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
