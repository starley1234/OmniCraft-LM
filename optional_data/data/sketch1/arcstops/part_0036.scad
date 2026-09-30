$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[60.569, 0], [59.381, 9.677], [55.887, 18.779], [48.824, 15.023], [44.135, 21.648], [37.931, 26.881], [30.609, 30.384], [22.642, 31.933], [14.542, 31.427], [6.829, 28.9], [0, 24.513], [6.428, 16.853], [15.247, 21.347], [25.143, 21.519], [34.114, 17.336], [40.343, 9.644], [42.569, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
