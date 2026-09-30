$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 12.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[49, 20.475], [49.315, 25.56], [49.335, 31.616], [47.596, 38.474], [43.137, 44.862], [36.087, 48.904], [27.873, 49.18], [19.953, 46.855], [13.009, 42.392], [7.604, 36.154], [2.94, 29.008], [0, 20.475], [2.94, 11.943], [8.326, 5.261], [15.175, 1.058], [22.649, 0], [29.231, 1.218], [34.476, 3.255], [39.062, 5.012], [43.133, 7.628], [46.301, 11.285], [48.311, 15.686]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
