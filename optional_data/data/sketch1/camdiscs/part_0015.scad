$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 6.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[40, 18.177], [39.761, 23.623], [38.462, 29.41], [35.278, 35.075], [29.915, 39.457], [23, 41.177], [15.893, 40.051], [9.481, 36.784], [4.393, 31.696], [1.126, 25.284], [0, 18.177], [1.126, 11.069], [4.897, 5.024], [10.722, 1.278], [17.094, 0], [23, 0.553], [28.253, 2.009], [32.992, 4.423], [36.753, 8.184], [39.168, 12.923]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
