$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[46.679, 0], [47.429, 2.067], [48.103, 4.16], [54.504, 4.754], [55.559, 9.474], [50.02, 12.737], [50.302, 14.918], [50.503, 17.108], [56.62, 19.084], [56.62, 23.92], [50.503, 25.896], [50.302, 28.086], [50.02, 30.267], [55.559, 33.53], [54.504, 38.25], [48.103, 38.844], [47.429, 40.937], [46.679, 43.004], [0, 25.086], [0.175, 24.592], [0.323, 24.09], [0.445, 23.581], [0.541, 23.066], [0.609, 22.547], [0.65, 22.025], [0.664, 21.502], [0.65, 20.979], [0.609, 20.457], [0.541, 19.938], [0.445, 19.423], [0.323, 18.914], [0.175, 18.412], [0, 17.918]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
