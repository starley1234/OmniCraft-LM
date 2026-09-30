$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[50.712, 0], [50.088, 6.488], [48.237, 12.737], [40.819, 9.74], [37.359, 15.802], [32.411, 20.725], [26.332, 24.155], [19.559, 25.844], [12.581, 25.67], [5.901, 23.646], [0, 19.917], [7.713, 10.725], [13.326, 13.584], [19.623, 13.694], [25.332, 11.032], [29.296, 6.137], [30.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
