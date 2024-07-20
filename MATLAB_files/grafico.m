figure();
hold on

set(gca,'FontSize',18)
xlabel('$t[s]$','interpreter','latex','FontSize',18);
ylabel('$Frecuencia[Hz]$','interpreter','latex','FontSize',18);


spectrogram(y_con_clicks,1984,992,[],fs,'yaxis');


%% --------------------------------------------------------------------
subplot(1,2,2);
plot((1:length(y_con_clicks))/fs,y_con_clicks,'black');
legend('Señal con clicks','FontSize',15);
grid on;
grid minor;
set(gca,'FontSize',18)
xlabel('$t[s]$','interpreter','latex','FontSize',18);
ylabel('Amplitud','interpreter','latex','FontSize',18);

hold off