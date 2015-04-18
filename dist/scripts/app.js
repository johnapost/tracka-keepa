var app, appUrl;

if (window.location.host === 'localhost:4000') {
  appUrl = 'https://tracka-keepa-dev.firebaseio.com';
} else {
  appUrl = window.location.host;
}

app = angular.module('trackaKeepa', ['firebase']);

app.constant('Modernizr', Modernizr);

window.console = window.console || {};

window.console.log = window.console.log || function() {};

$(function() {
  return $("a[href='#']").click(function(e) {
    return e.preventDefault();
  });
});

app.directive('loginForm', [
  function() {
    return {
      restrict: 'A',
      scope: true,
      link: function(scope, element, attrs) {
        scope.user = {
          email: null,
          password: null
        };
        return scope.submit = function() {
          return console.log(scope.user);
        };
      }
    };
  }
]);

app.directive('registerForm', [
  '$firebaseAuth', function($firebaseAuth) {
    return {
      restrict: 'A',
      scope: true,
      link: function(scope, element, attrs) {
        var auth, ref;
        ref = new Firebase(appUrl);
        auth = $firebaseAuth(ref);
        scope.user = {
          email: null,
          password: null
        };
        return scope.submit = function() {
          return auth.$createUser({
            email: scope.user.email,
            password: scope.user.password
          }).then(function(userData) {
            console.log("Successfully created user account: " + userData.uid);
            return $('[flash]').text('Account successfully created');
          })["catch"](function(error) {
            return console.log("Error creating user: " + error);
          });
        };
      }
    };
  }
]);

app.directive('tabSet', [
  'Tab', function(Tab) {
    return {
      restrict: 'A',
      scope: true,
      link: function(scope, element, attrs) {
        return scope.tabSet = Tab.newTabSet();
      }
    };
  }
]);

app.directive('tabToggle', [
  'Tab', function(Tab) {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        angular.element(element).bind('click', function() {
          if (!$(element).is('[tab-active]')) {
            return Tab.toggleTab({
              id: scope.tabSet,
              tabbed: attrs.tabToggle
            });
          }
        });
        return scope.$on('tabToggle', function(ev, val) {
          if (scope.tabSet === val.id) {
            if (attrs.tabToggle === val.tabbed) {
              return $(element).attr('tab-active', '');
            } else {
              return $(element).removeAttr('tab-active');
            }
          }
        });
      }
    };
  }
]);

app.directive('tabContent', [
  function() {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        var closeTab, openTab;
        openTab = function() {
          return $(element).attr('tab-active', '');
        };
        closeTab = function() {
          return $(element).removeAttr('tab-active');
        };
        return scope.$on('tabToggle', function(ev, val) {
          if (scope.tabSet === val.id) {
            if (attrs.tabContent === val.tabbed) {
              return openTab();
            } else {
              return closeTab();
            }
          }
        });
      }
    };
  }
]);

app.factory('Tab', [
  '$rootScope', function($rootScope) {
    var tabSets;
    tabSets = [];
    return {
      newTabSet: function() {
        var tabSet;
        tabSet = tabSets.length + 1;
        tabSets.push({
          id: tabSet,
          tabbed: ''
        });
        return tabSet;
      },
      toggleTab: function(args) {
        var i, len, n, results;
        results = [];
        for (i = 0, len = tabSets.length; i < len; i++) {
          n = tabSets[i];
          if (n.id === args.id) {
            n.tabbed = args.tabbed;
            $rootScope.$broadcast('tabToggle', n);
            break;
          } else {
            results.push(void 0);
          }
        }
        return results;
      }
    };
  }
]);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImFwcC5jb2ZmZWUiLCJjb21wb25lbnRzL2xvZ2luRm9ybS9sb2dpbkZvcm0uZGlyZWN0aXZlLmNvZmZlZSIsImNvbXBvbmVudHMvcmVnaXN0ZXJGb3JtL3JlZ2lzdGVyRm9ybS5kaXJlY3RpdmUuY29mZmVlIiwiY29tcG9uZW50cy90YWJUb2dnbGUvdGFiVG9nZ2xlLmRpcmVjdGl2ZS5jb2ZmZWUiLCJjb21wb25lbnRzL3RhYlRvZ2dsZS90YWJUb2dnbGUuZmFjdG9yeS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQ0EsSUFBQSxXQUFBOztBQUFBLElBQUcsTUFBTSxDQUFDLFFBQVEsQ0FBQyxJQUFoQixLQUF3QixnQkFBM0I7QUFDRSxFQUFBLE1BQUEsR0FBUyx5Q0FBVCxDQURGO0NBQUEsTUFBQTtBQUdFLEVBQUEsTUFBQSxHQUFTLE1BQU0sQ0FBQyxRQUFRLENBQUMsSUFBekIsQ0FIRjtDQUFBOztBQUFBLEdBTUEsR0FBTSxPQUFPLENBQUMsTUFBUixDQUFlLGFBQWYsRUFBOEIsQ0FBQyxVQUFELENBQTlCLENBTk4sQ0FBQTs7QUFBQSxHQVNHLENBQUMsUUFBSixDQUFhLFdBQWIsRUFBMEIsU0FBMUIsQ0FUQSxDQUFBOztBQUFBLE1BWU0sQ0FBQyxPQUFQLEdBQWlCLE1BQU0sQ0FBQyxPQUFQLElBQWtCLEVBWm5DLENBQUE7O0FBQUEsTUFhTSxDQUFDLE9BQU8sQ0FBQyxHQUFmLEdBQXFCLE1BQU0sQ0FBQyxPQUFPLENBQUMsR0FBZixJQUFzQixTQUFBLEdBQUEsQ0FiM0MsQ0FBQTs7QUFBQSxDQWdCQSxDQUFFLFNBQUEsR0FBQTtTQUNBLENBQUEsQ0FBRSxhQUFGLENBQWdCLENBQUMsS0FBakIsQ0FBdUIsU0FBQyxDQUFELEdBQUE7V0FDckIsQ0FBQyxDQUFDLGNBQUYsQ0FBQSxFQURxQjtFQUFBLENBQXZCLEVBREE7QUFBQSxDQUFGLENBaEJBLENBQUE7O0FDREEsR0FBRyxDQUFDLFNBQUosQ0FBYyxXQUFkLEVBQTJCO0VBQ3pCLFNB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cC5qcyIsInNvdXJjZXNDb250ZW50IjpbIiMgQ29ubmVjdCB0byBwcm9wZXIgZmlyZWJhc2VcbmlmIHdpbmRvdy5sb2NhdGlvbi5ob3N0IGlzICdsb2NhbGhvc3Q6NDAwMCdcbiAgYXBwVXJsID0gJ2h0dHBzOi8vdHJhY2thLWtlZXBhLWRldi5maXJlYmFzZWlvLmNvbSdcbmVsc2VcbiAgYXBwVXJsID0gd2luZG93LmxvY2F0aW9uLmhvc3RcblxuIyBDcmVhdGUgYW5ndWxhciBhcHBcbmFwcCA9IGFuZ3VsYXIubW9kdWxlICd0cmFja2FLZWVwYScsIFsnZmlyZWJhc2UnXVxuXG4jIE1ha2UgTW9kZXJuaXpyIGluamVjdGFibGVcbmFwcC5jb25zdGFudCAnTW9kZXJuaXpyJywgTW9kZXJuaXpyXG5cbiMgQ3JlYXRlIGNvbnNvbGUubG9nIGZvciBpbmNvbXBhdGlibGUgYnJvd3NlcnNcbndpbmRvdy5jb25zb2xlID0gd2luZG93LmNvbnNvbGUgb3Ige31cbndpbmRvdy5jb25zb2xlLmxvZyA9IHdpbmRvdy5jb25zb2xlLmxvZyBvciAtPlxuXG4jIEVtcHR5IGFuY2hvciBsaW5rcyBnbyBub3doZXJlXG4kIC0+XG4gICQoXCJhW2hyZWY9JyMnXVwiKS5jbGljayAoZSkgLT5cbiAgICBlLnByZXZlbnREZWZhdWx0KCkiLCJhcHAuZGlyZWN0aXZlICdsb2dpbkZvcm0nLCBbXG4gIC0+XG4gICAgcmVzdHJpY3Q6ICdBJ1xuICAgIHNjb3BlOiB0cnVlXG4gICAgbGluazogKHNjb3BlLCBlbGVtZW50LCBhdHRycykgLT5cbiAgICAgIHNjb3BlLnVzZXIgPVxuICAgICAgICBlbWFpbDogbnVsbFxuICAgICAgICBwYXNzd29yZDogbnVsbFxuXG4gICAgICBzY29wZS5zdWJtaXQgPSAtPlxuICAgICAgICBjb25zb2xlLmxvZyBzY29wZS51c2VyXG5dIiwiYXBwLmRpcmVjdGl2ZSAncmVnaXN0ZXJGb3JtJywgW1xuICAnJGZpcmViYXNlQXV0aCdcbiAgKCRmaXJlYmFzZUF1dGgpIC0+XG4gICAgcmVzdHJpY3Q6ICdBJ1xuICAgIHNjb3BlOiB0cnVlXG4gICAgbGluazogKHNjb3BlLCBlbGVtZW50LCBhdHRycykgLT5cbiAgICAgIHJlZiA9IG5ldyBGaXJlYmFzZSBhcHBVcmxcbiAgICAgIGF1dGggPSAkZmlyZWJhc2VBdXRoIHJlZlxuXG4gICAgICBzY29wZS51c2VyID1cbiAgICAgICAgZW1haWw6IG51bGxcbiAgICAgICAgcGFzc3dvcmQ6IG51bGxcblxuICAgICAgc2NvcGUuc3VibWl0ID0gLT5cbiAgICAgICAgYXV0aC4kY3JlYXRlVXNlclxuICAgICAgICAgIGVtYWlsOiBzY29wZS51c2VyLmVtYWlsXG4gICAgICAgICAgcGFzc3dvcmQ6IHNjb3BlLnVzZXIucGFzc3dvcmRcbiAgICAgICAgLnRoZW4gKHVzZXJEYXRhKSAtPlxuICAgICAgICAgIGNvbnNvbGUubG9nIFwiU3VjY2Vzc2Z1bGx5IGNyZWF0ZWQgdXNlciBhY2NvdW50OiAje3VzZXJEYXRhLnVpZH1cIlxuICAgICAgICAgICQoJ1tmbGFzaF0nKS50ZXh0ICdBY2NvdW50IHN1Y2Nlc3NmdWxseSBjcmVhdGVkJ1xuICAgICAgICAuY2F0Y2ggKGVycm9yKSAtPlxuICAgICAgICAgIGNvbnNvbGUubG9nIFwiRXJyb3IgY3JlYXRpbmcgdXNlcjogI3tlcnJvcn1cIlxuXSIsImFwcC5kaXJlY3RpdmUgJ3RhYlNldCcsIFtcbiAgJ1RhYidcbiAgKFRhYikgLT5cbiAgICByZXN0cmljdDogJ0EnXG4gICAgc2NvcGU6IHRydWVcbiAgICBsaW5rOiAoc2NvcGUsIGVsZW1lbnQsIGF0dHJzKSAtPlxuXG4gICAgICAjIEFubm91bmNlIHRvIFRhYiBmYWN0b3J5IHRoYXQgSSBuZWVkIGEgbmV3IHRhYlNldCBhc3NpZ25lZFxuICAgICAgc2NvcGUudGFiU2V0ID0gVGFiLm5ld1RhYlNldCgpXG5dXG5cbiMgQ29udHJvbHMgdG9nZ2xlIHN0YXRlXG5hcHAuZGlyZWN0aXZlICd0YWJUb2dnbGUnLCBbXG4gICdUYWInXG4gIChUYWIpIC0+XG4gICAgcmVzdHJpY3Q6ICdBJ1xuICAgIGxpbms6IChzY29wZSwgZWxlbWVudCwgYXR0cnMpIC0+XG5cbiAgICAgICMgSWRlbnRpZnkgc2VsZiBhcyB0b2dnbGluZyB0byBmYWN0b3J5XG4gICAgICBhbmd1bGFyLmVsZW1lbnQoZWxlbWVudCkuYmluZCAnY2xpY2snLCAtPlxuXG4gICAgICAgIHVubGVzcyAkKGVsZW1lbnQpLmlzICdbdGFiLWFjdGl2ZV0nXG5cbiAgICAgICAgICAjIFBhc3MgbXkgdGFiU2V0IGFuZCB0YWJUb2dnbGUgdG8gZmFjdG9yeVxuICAgICAgICAgIFRhYi50b2dnbGVUYWIgaWQ6IHNjb3BlLnRhYlNldCwgdGFiYmVkOiBhdHRycy50YWJUb2dnbGVcblxuICAgICAgIyBMaXN0ZW4gZm9yIHRhYlRvZ2dsZSBldmVudFxuICAgICAgc2NvcGUuJG9uICd0YWJUb2dnbGUnLCAoZXYsIHZhbCkgLT5cbiAgICAgICAgaWYgc2NvcGUudGFiU2V0IGlzIHZhbC5pZFxuXG4gICAgICAgICAgIyBBZGQgYWN0aXZlIGF0dHJpYnV0ZSBmb3IgYW55IENTUyBuZWVkc1xuICAgICAgICAgIGlmIGF0dHJzLnRhYlRvZ2dsZSBpcyB2YWwudGFiYmVkXG4gICAgICAgICAgICAkKGVsZW1lbnQpLmF0dHIgJ3RhYi1hY3RpdmUnLCAnJ1xuICAgICAgICAgIGVsc2VcbiAgICAgICAgICAgICQoZWxlbWVudCkucmVtb3ZlQXR0ciAndGFiLWFjdGl2ZSdcbl1cblxuIyBMaXN0ZW5zIGZvciBzdGF0ZSBhbmQgYW5pbWF0ZXNcbmFwcC5kaXJlY3RpdmUgJ3RhYkNvbnRlbnQnLCBbXG4gIC0+XG4gICAgcmVzdHJpY3Q6ICdBJ1xuICAgIGxpbms6IChzY29wZSwgZWxlbWVudCwgYXR0cnMpIC0+XG5cbiAgICAgIG9wZW5UYWIgPSAtPiAkKGVsZW1lbnQpLmF0dHIgJ3RhYi1hY3RpdmUnLCAnJ1xuICAgICAgY2xvc2VUYWIgPSAtPiAkKGVsZW1lbnQpLnJlbW92ZUF0dHIgJ3RhYi1hY3RpdmUnXG5cbiAgICAgICMgTGlzdGVuIGZvciBtYXRjaGluZyB0b2dnbGUgZXZlbnRcbiAgICAgIHNjb3BlLiRvbiAndGFiVG9nZ2xlJywgKGV2LCB2YWwpIC0+XG4gICAgICAgIGlmIHNjb3BlLnRhYlNldCBpcyB2YWwuaWRcbiAgICAgICAgICBpZiBhdHRycy50YWJDb250ZW50IGlzIHZhbC50YWJiZWRcbiAgICAgICAgICAgIG9wZW5UYWIoKVxuICAgICAgICAgIGVsc2VcbiAgICAgICAgICAgIGNsb3NlVGFiKClcbl0iLCJhcHAuZmFjdG9yeSAnVGFiJywgW1xuICAnJHJvb3RTY29wZSdcbiAgKCRyb290U2NvcGUpIC0+XG4gICAgdGFiU2V0cyA9IFtdXG5cbiAgICAjIENyZWF0ZSBuZXcgdGFiU2V0XG4gICAgbmV3VGFiU2V0OiAtPlxuICAgICAgdGFiU2V0ID0gdGFiU2V0cy5sZW5ndGggKyAxXG4gICAgICB0YWJTZXRzLnB1c2ggaWQ6IHRhYlNldCwgdGFiYmVkOiAnJ1xuXG4gICAgICB0YWJTZXRcblxuICAgICMgQWNjZXB0IHRvZ2dsZSBhY3Rpb25zIGFuZCBicm9hZGNhc3QgZXZlbnRcbiAgICB0b2dnbGVUYWI6IChhcmdzKSAtPlxuXG4gICAgICAjIExvb3AgdGhyb3VnaCB0YWJTZXRzIHRvIGZpbmQgdGhlIGNvcnJlY3Qgb25lXG4gICAgICBmb3IgbiBpbiB0YWJTZXRzXG4gICAgICAgIGlmIG4uaWQgaXMgYXJncy5pZFxuICAgICAgICAgIG4udGFiYmVkID0gYXJncy50YWJiZWRcblxuICAgICAgICAgICMgQnJvYWRjYXN0IHJlbGV2YW50IHRvZ2dsZSBldmVudFxuICAgICAgICAgICRyb290U2NvcGUuJGJyb2FkY2FzdCAndGFiVG9nZ2xlJywgblxuICAgICAgICAgIGJyZWFrXG5dIl0sInNvdXJjZVJvb3QiOiIvc291cmNlLyJ9