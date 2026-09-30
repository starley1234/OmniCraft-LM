$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[33.352, 17.715], [39.484, 21.315], [32.363, 25.542], [35.576, 31.885], [27.3, 31.591], [26.573, 38.664], [19.771, 33.943], [15.335, 39.5], [12.165, 31.85], [5.429, 34.127], [6.897, 25.978], [0, 24.252], [5.641, 18.19], [0.772, 13.009], [8.795, 10.959], [7.499, 3.968], [15.357, 6.582], [18.047, 0], [23.244, 6.446], [29.066, 2.364], [29.953, 10.597], [37.057, 10.31]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
