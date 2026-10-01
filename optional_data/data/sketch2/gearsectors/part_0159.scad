$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[46.679, 0], [47.285, 1.651], [47.843, 3.32], [55.048, 2.961], [55.969, 6.527], [49.493, 9.704], [49.813, 11.434], [50.083, 13.172], [57.246, 14.028], [57.556, 17.698], [50.638, 19.743], [50.664, 21.502], [50.638, 23.261], [57.556, 25.306], [57.246, 28.976], [50.083, 29.832], [49.813, 31.57], [49.493, 33.3], [55.969, 36.477], [55.048, 40.043], [47.843, 39.684], [47.285, 41.353], [46.679, 43.004], [0, 25.086], [0.175, 24.592], [0.323, 24.09], [0.445, 23.581], [0.541, 23.066], [0.609, 22.547], [0.65, 22.025], [0.664, 21.502], [0.65, 20.979], [0.609, 20.457], [0.541, 19.938], [0.445, 19.423], [0.323, 18.914], [0.175, 18.412], [0, 17.918]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
