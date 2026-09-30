$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 22 mm hub radius, 18 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[61.003, 33.843], [70.991, 49.831], [77.401, 53.33], [57.595, 52.627], [51.321, 70.404], [52.583, 77.597], [40.783, 61.674], [22.973, 67.853], [18.136, 73.324], [23.229, 54.17], [7.293, 44.099], [0, 43.728], [18.15, 35.767], [16.089, 17.029], [11.831, 11.096], [29.371, 20.323], [42.736, 7.028], [44.72, 0], [48.443, 19.466], [67.17, 21.626], [73.902, 18.796]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
