$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[40.893, 0], [40.581, 4.454], [39.653, 8.82], [33.885, 7.167], [31.538, 12.775], [27.952, 17.684], [23.324, 21.627], [17.907, 24.387], [11.997, 25.814], [5.917, 25.829], [0, 24.432], [2.052, 18.794], [9.591, 19.988], [17.027, 18.271], [23.279, 13.893], [27.436, 7.492], [28.893, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
