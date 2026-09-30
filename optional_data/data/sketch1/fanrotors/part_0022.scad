$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 18 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[60.838, 33.991], [70.826, 49.979], [77.689, 52.157], [57.43, 52.775], [51.156, 70.552], [53.733, 77.275], [40.618, 61.821], [22.808, 68.001], [19.158, 74.207], [23.064, 54.318], [7.128, 44.246], [0, 45.262], [17.985, 35.915], [15.924, 17.177], [10.685, 12.237], [29.206, 20.47], [42.571, 7.175], [43.167, 0], [48.278, 19.614], [67.005, 21.774], [72.987, 17.766]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
