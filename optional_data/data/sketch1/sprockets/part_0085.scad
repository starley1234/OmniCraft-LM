$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[47.587, 21.412], [51.852, 27.221], [45.713, 34.879], [45.75, 42.086], [36.282, 44.673], [32.075, 50.525], [22.895, 47.053], [16.052, 49.314], [10.666, 41.109], [3.8, 38.917], [4.266, 29.113], [0, 23.304], [6.139, 15.646], [6.103, 8.439], [15.571, 5.852], [19.777, 0], [28.958, 3.472], [35.8, 1.21], [41.187, 9.416], [48.052, 11.608]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
