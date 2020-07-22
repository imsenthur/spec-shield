l = 297;
fw = 135/2;
fh = 20;

mx = 0;
my = 0;

syms a x
assume(a, 'real')
assumeAlso(a, 'positive')
assumeAlso(a ~= 0)

fig = figure;
set(gca,'visible', 'off')
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
set(gcf, 'Position',  [200, 200, 500, 500])

axis equal;
xlim([-150, 150]);
ylim([-150, 150]);
yline(0, '--k'); hold on;
xline(0, '--k'); hold on;
line([-fw-2 fw+2], [0, 0], 'Color', 'Black', 'LineStyle','-', 'LineWidth', 6); hold on;
line([-fw -fw], [0, 100], 'Color', 'Black', 'LineStyle','-', 'LineWidth', 5); hold on;
line([fw fw], [0, 100], 'Color', 'Black', 'LineStyle','-', 'LineWidth', 5); hold on;

valid = [];

for y_inc = 0:5:30
    curves = [];
    my = y_inc;
    for x_inc = 0:5:40
        mx = x_inc;
        y = a*x^2 + (fh + my) - a*(fw + mx)^2;
        f = sqrt(1 + diff(y, x)^2);
        eqn = int(f, 0, fw+mx) - l/2 == 0;
        
        subs_y = subs(y, a, solve(eqn, a));
        soln = vpasolve(subs_y == 0, x);

        if soln(2) > fw
            xincidence = -0.75*fw;
            yincidence = subs(subs_y, x, xincidence);
            nslope = abs(-1/subs(diff(subs_y, x), x, xincidence));    
            rslope = 2*nslope/(1-nslope^2);

            refray = yincidence + rslope*(x - xincidence);
            refpoint = vpasolve(refray==0, x);

            if refpoint < xincidence
                valid(end+1) = mx;
                curves(end+1) = fplot(subs_y, [-1*(fw+mx), fw+mx], 'LineWidth', 5);
                saveas(fig, strcat('frame_', num2str(y_inc),'_', num2str(x_inc), '.png'))
%                 pause(1)
                
                r2 = [];
                count = 1;
                
                for i = 0.2:0.1:0.75
                    xincidence = -i*fw;
                    yincidence = subs(subs_y, x, xincidence);
                    nslope = abs(-1/subs(diff(subs_y, x), x, xincidence));    
                    rslope = 2*nslope/(1-nslope^2);

                    refray = yincidence + rslope*(x - xincidence);
                    refpoint = vpasolve(refray==0, x);
                    r1 = line([xincidence 100], [yincidence, yincidence], 'Color', 'y', 'LineStyle','-', 'LineWidth', 3); hold on;              
                    saveas(fig, strcat('frame_', num2str(y_inc),'_', num2str(x_inc), '_', num2str(count), '.png'))
                    count = count + 1;
%                     pause(0.5)
                    temp_r = fplot(refray, [-fw, xincidence], '-y', 'LineWidth', 3);
                    r2(end+1) = temp_r;
%                     pause(0.5)
                    saveas(fig, strcat('frame_', num2str(y_inc),'_', num2str(x_inc), '_', num2str(count), '.png'))
                    count = count + 1;
                    delete(r1);
%                     pause(0.5)
                    saveas(fig, strcat('frame_', num2str(y_inc),'_', num2str(x_inc), '_', num2str(count), '.png'))
                    count = count + 1;
                end                
                delete(r2);
                saveas(fig, strcat('frame_', num2str(y_inc),'_', num2str(x_inc), '_', num2str(count), '.png'))
            else
                curves(end+1) = fplot(subs_y, [-1*(fw+mx), fw+mx], '-k', 'LineWidth', 1);
                
            end 
        else
            curves(end+1) = fplot(subs_y, [-1*(fw+mx), fw+mx], '--k', 'LineWidth', 1);
        end
        saveas(fig, strcat('frame_', num2str(y_inc), '_', num2str(x_inc), '.png'))
        drawnow
    end
    delete(curves);
end
saveas(fig, strcat('frame_end', num2str(y_inc), '_', num2str(x_inc), '.png'))


