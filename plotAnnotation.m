function plotAnnotation(site)
% load(filename,'site')
areas=flipud(site.ont.id(~isnan(site.ont.id) & site.ont.id~=0));
areaN=flipud(site.ont.name(~isnan(site.ont.id) & site.ont.id~=0));
areaD=diff(areas);
areaB=[1; find(areaD~=0); length(areas)];
hexcode=importOntology('hexcode.csv');

figure % plot a line
subplot(161)
hold on
for i=1:length(areaB)-1
    ids = areas(areaB(i+1));
    [found, rows] = ismember(ids, hexcode.id); % hexcode
    if found ==0
        color='w';
    else
        color = hexcode.name{rows(found)};
        color = sscanf(color,'%2x%2x%2x',[1 3])/255;
    end
    plot([1 1],[areaB(i) areaB(i+1)]*site.params.SiteDist,'Color',color,'LineWidth',40)% plot color line
    text(3,(areaB(i)+areaB(i+1))/2*site.params.SiteDist,areaN(areaB(i+1)),'FontSize',10)% annotation beside the line
end
box off
ylabel('Depth in the brain (mm)')
set(gca,'TickDir','out')
ax=gca;
ax.YDir = 'reverse';
ylim([0 areaB(end)*site.params.SiteDist])