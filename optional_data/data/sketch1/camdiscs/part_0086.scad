$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 10.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[44, 19.587], [43.343, 24.897], [41.809, 30.347], [39.106, 36.249], [34.232, 41.846], [27, 45.282], [18.713, 45.09], [11.13, 41.431], [5.157, 35.457], [1.321, 27.931], [0, 19.587], [1.497, 11.301], [6.213, 4.484], [13.243, 0.652], [20.636, 0], [27, 1.282], [32.31, 3.244], [36.992, 5.834], [40.753, 9.595], [43.168, 14.334]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
