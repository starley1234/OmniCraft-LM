$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[40.893, 0], [39.942, 7.742], [37.147, 15.023], [31.849, 12.206], [28.893, 16.613], [25.103, 20.328], [20.638, 23.196], [15.684, 25.097], [10.447, 25.953], [5.146, 25.729], [0, 24.432], [2.052, 18.794], [9.591, 19.988], [17.027, 18.271], [23.279, 13.893], [27.436, 7.492], [28.893, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
